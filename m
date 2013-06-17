From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [virtio-spec PATCH 0/5] Receiving Used Buffers example code:
	cleanups and an extra mb()
Date: Mon, 17 Jun 2013 11:47:13 +0930
Message-ID: <87txkxpjkm.fsf@rustcorp.com.au>
References: <1370713168-20624-1-git-send-email-lersek@redhat.com>
	<CAJSP0QXNu1jdHXpN7hpEfZPdGJf38H75AUdy3n3HAr8kg5gSww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QXNu1jdHXpN7hpEfZPdGJf38H75AUdy3n3HAr8kg5gSww@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Jordan Justen <jordan.l.justen@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Stefan Hajnoczi <stefanha@gmail.com> writes:
> On Sat, Jun 8, 2013 at 7:39 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>> Patches before the last are small cleanups.
>>
>> In the last patch I'm trying to extract / generalize an idea from Stefan
>> Hajnoczi's review of my virtio-net driver for OVMF.

How about a single patch which just replaces the completely broken
example? :)

>>   Receiving Used Buffers: prevent speculative load when not
>>     sequentially consistent

Yes, though this only needs to be a rmb().

In the OASIS 1.0 spec, I'd like an appendix with tested code for doing
these operations (probably based on a simplifeid version of vringh.c).

Thanks,
Rusty.
