From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/3] virtiofs: Small Cleanups for 5.5
Date: Wed, 30 Oct 2019 11:07:16 -0400
Message-ID: <20191030150719.29048-1-vgoyal__37608.331038949$1572448104$gmane$org@redhat.com>
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
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Cc: dgilbert@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Miklos,

Here are few small cleanups for virtiofs for 5.5. I had received some
comments from Michael Tsirkin on original virtiofs patches and these
cleanups are result of these comments.

Thanks
Vivek

Vivek Goyal (3):
  virtiofs: Use a common function to send forget
  virtiofs: Do not send forget request "struct list_head" element
  virtiofs: Use completions while waiting for queue to be drained

 fs/fuse/virtio_fs.c | 204 ++++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 101 deletions(-)

-- 
2.20.1
