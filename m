From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/5] virtiofs: Fix couple of deadlocks
Date: Tue, 15 Oct 2019 13:46:21 -0400
Message-ID: <20191015174626.11593-1-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc: miklos@szeredi.hu, chirantan@chromium.org, dgilbert@redhat.com, virtualization@lists.linux-foundation.org, stefanha@redhat.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

We have couple of places which can result in deadlock. This patch series
fixes these.

We can be called with fc->bg_lock (for background requests) while
submitting a request. This leads to two constraints.

- We can't end requests in submitter's context and call fuse_end_request()
  as it tries to take fc->bg_lock as well. So queue these requests on a
  list and use a worker to end these requests.

- If virtqueue is full, we can wait with fc->bg_lock held for queue to
  have space. Worker which is completing the request gets blocked on
  fc->bg_lock as well. And that means requests are not completing, that
  means descriptors are not being freed and that means submitter can't
  make progress. Deadlock. 

  Fix this by punting the requests to a list and retry submission later
  with the help of a worker.

Thanks
Vivek

Vivek Goyal (5):
  virtiofs: Do not end request in submission context
  virtiofs: No need to check fpq->connected state
  virtiofs: Set FR_SENT flag only after request has been sent
  virtiofs: Count pending forgets as in_flight forgets
  virtiofs: Retry request submission from worker context

 fs/fuse/virtio_fs.c | 165 +++++++++++++++++++++++++++++---------------
 1 file changed, 111 insertions(+), 54 deletions(-)

-- 
2.20.1
