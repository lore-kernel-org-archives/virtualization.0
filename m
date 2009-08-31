From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 20:01:01 +0530
Message-ID: <20090831143101.GA16943__48549.260167829$1251729218$gmane$org@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
	<4A9A7525.6010707@codemonkey.ws>
	<20090830131738.GC3401@amit-x200.redhat.com>
	<4A9BCD61.2040903@codemonkey.ws>
	<20090831135147.GA16371@amit-x200.redhat.com>
	<4A9BDC59.1090801@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A9BDC59.1090801@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Aug 31 2009 [09:21:13], Anthony Liguori wrote:
> Amit Shah wrote:
>> Can you please explain your rationale for being so rigid about merging
>> the two drivers?
>>   
>
> Because they do the same thing.  I'm not going to constantly rehash  
> this.  It's been explained multiple times.

It hardly looks like the same thing each passing day.

I've also mentioned that each minimal virtio device would start out
looking the same.

We're ending up having to compromise on the performance or functionality
or simplicity the devices just because of this restriction.

> If there are implementation issues within the Linux drivers because of  
> peculiarities of hvc then hvc needs to be fixed.  It has nothing to do  
> with the driver ABI which is what qemu cares about.

I'd welcome that effort as well. But we all know that's not going to
happen anytime soon.

Also, there's no driver ABI for virtio-serial yet. 

		Amit
