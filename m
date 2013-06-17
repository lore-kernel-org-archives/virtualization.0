From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [virtio-spec PATCH 0/5] Receiving Used Buffers example code:
	cleanups and an extra mb()
Date: Mon, 17 Jun 2013 09:29:23 +0200
Message-ID: <51BEBAD3.4070403@redhat.com>
References: <1370713168-20624-1-git-send-email-lersek@redhat.com>
	<CAJSP0QXNu1jdHXpN7hpEfZPdGJf38H75AUdy3n3HAr8kg5gSww@mail.gmail.com>
	<87txkxpjkm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87txkxpjkm.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jordan Justen <jordan.l.justen@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/17/13 04:17, Rusty Russell wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>> On Sat, Jun 8, 2013 at 7:39 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>>> Patches before the last are small cleanups.
>>>
>>> In the last patch I'm trying to extract / generalize an idea from Stefan
>>> Hajnoczi's review of my virtio-net driver for OVMF.
> 
> How about a single patch which just replaces the completely broken
> example? :)

Do you want me to squash the series into one patch and repost?

>>>   Receiving Used Buffers: prevent speculative load when not
>>>     sequentially consistent
> 
> Yes, though this only needs to be a rmb().

Probably, but the spec never qualifies the memory barriers it
recommends. (Maybe their read/write types should be obvious to the
reader. I didn't give their types much thought because in edk2/OVMF
there's only MemoryFence().)

In any case I'll take this as your approval of the 5/5 patch. Thanks!

> In the OASIS 1.0 spec, I'd like an appendix with tested code for doing
> these operations (probably based on a simplifeid version of vringh.c).

(
I assume the tested code should come from one of the more sophisticated
drivers (that also have a unix-y coding style). Also, I've been actively
avoiding reading other virtio code (qemu, kernel, SeaBIOS, iPXE etc)
except when I was stuck with an OVMF driver and (a) it looked like there
was some silent requirement/assumption in qemu that had not been spelled
out in the spec, (b) I was being dyslexic.

Thus I can't really suggest code for the appendix (although the OVMF
drivers do work).
)

Thanks,
Laszlo
