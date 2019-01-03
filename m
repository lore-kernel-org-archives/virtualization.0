From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 2/2] virtio-balloon: improve update_balloon_size_func
Date: Thu, 3 Jan 2019 10:42:36 +0100
Message-ID: <20190103104236.06568289.cohuck__1189.4435891465$1546508446$gmane$org@redhat.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
	<1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  3 Jan 2019 13:31:02 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
