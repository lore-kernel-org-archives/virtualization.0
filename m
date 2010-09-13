From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Mon, 13 Sep 2010 13:05:57 +0930
Message-ID: <201009131305.58893.rusty__25453.5337364816$1284349105$gmane$org@rustcorp.com.au>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
	<72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>
	<4C8C96BB.2010804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C8C96BB.2010804@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 12 Sep 2010 06:30:43 pm Avi Kivity wrote:
>   On 09/12/2010 02:42 AM, Alexander Graf wrote:
> > On 24.08.2010, at 15:48, Alexander Graf wrote:
> >
> >> The one big missing feature in s390-virtio was hotplugging. This is no more.
> >> This patch implements hotplug add support, so you can on the fly add new devices
> >> in the guest.
> >>
> >> Keep in mind that this needs a patch for qemu to actually leverage the
> >> functionality.
> >>
> >> Signed-off-by: Alexander Graf<agraf@suse.de>
> > ping (on the patch set)?
> >
> 
> Actually Marcelo applied it.  But the natural place for it is Rusty's 
> virtio tree.  Rusty, if you want to take it, let me know and I'll drop 
> it from kvm.git.

I thought it would be in the s390 tree, which is why I didn't take it...

But I'm *always* happy to let do the work!

Thanks,
Rusty.
