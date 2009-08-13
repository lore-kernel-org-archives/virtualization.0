From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an	inline
	function
Date: Thu, 13 Aug 2009 12:28:52 +0300
Message-ID: <4A83DCD4.9040705@redhat.com>
References: <20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws> <20090811084807.GA3029@redhat.com>
	<4A816EEB.4070707@codemonkey.ws>
	<20090811134331.GA22661@redhat.com>
	<4A819780.4040002@codemonkey.ws>
	<20090811162537.GA25705@redhat.com>
	<4A83157C.9040009@codemonkey.ws> <20090813061522.GD3029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813061522.GD3029@redhat.com>
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
Cc: qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/13/2009 09:15 AM, Michael S. Tsirkin wrote:
>
>> I wonder though if mmu notifiers can be used to make it transparent...
>>      
>
> Maybe they can, but that decision belongs to KVM.
> Avi, what do you think?
>
>    

I don't see how mmu notifiers help.  You can use mmu notifiers to sync 
an external mmu to the linux pagetables, but that's not the case here.

I see the following options:

- mprotect() guest memory, trap faults, mprotect() back

Will work, but exceedingly slowly and wastefully

- add a generic user visible dirty bit tracking based on linux ptes

A lot of work, not sure if useful beyond kvm

- implement vhost dirty bit tracking

Not too difficult; not sure if it's worth the effort though

- reuse the kvm dirty bitmap

Not too difficult but introduces tight coupling between vhost and kvm 
which might slow down development

- drop to userspace for live migration

Reuse qemu code, lose some performance

-- 
error compiling committee.c: too many arguments to function
