From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Mon, 24 May 2010 14:00:59 +0300
Message-ID: <4BFA5C6B.5070403__21953.360111411$1274698925$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
	<201005201438.17010.rusty@rustcorp.com.au>
	<20100523153134.GA14646@redhat.com> <4BF94CAD.5010504@redhat.com>
	<20100523155132.GA14733@redhat.com> <4BF951BE.1010402@redhat.com>
	<20100523163039.GC14733@redhat.com> <4BFA1E91.8060706@redhat.com>
	<20100524080518.GA16115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100524080518.GA16115@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/24/2010 11:05 AM, Michael S. Tsirkin wrote:
>
> Okay, but why is lockunshare faster than unshare?
>
>    

No idea.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
