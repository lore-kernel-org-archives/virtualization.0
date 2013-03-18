From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 0/2] Fix booting tcm_vhost + seabios
Date: Mon, 18 Mar 2013 14:26:14 -0700
Message-ID: <1363641974.3156.59.camel@haakon2.linux-iscsi.org>
References: <1363311916-23121-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363311916-23121-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Kevin O'Connor <kevin@koconnor.net>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-03-15 at 09:45 +0800, Asias He wrote:
> Asias He (2):
>   virtio-scsi: Set _DRIVER_OK flag before scsi target scanning
>   virtio-scsi: Pack struct virtio_scsi_{req_cmd,resp_cmd}
> 
>  src/virtio-scsi.c | 5 +++--
>  src/virtio-scsi.h | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 

Hi Asias,

Thanks for taking the initiative on this, and nice work tracking both of
these stubborn bugs down.

So with these out of the way, we're good to go for an RFC of Paolo's
vhost-scsi-pci code for upstream QEMU, yes..?

I'll have some extra bandwidth this week to spend time on the RFC if
you'd like, otherwise I'm happy with you making the upstream QEMU push
for Paolo's code. 

Whatever works best for you.  :)

Thank you,

--nab
