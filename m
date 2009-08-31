From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 09:21:13 -0500
Message-ID: <4A9BDC59.1090801__3625.36923862553$1251728563$gmane$org@codemonkey.ws>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
	<4A9A7525.6010707@codemonkey.ws>
	<20090830131738.GC3401@amit-x200.redhat.com>
	<4A9BCD61.2040903@codemonkey.ws>
	<20090831135147.GA16371@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090831135147.GA16371@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Can you please explain your rationale for being so rigid about merging
> the two drivers?
>   

Because they do the same thing.  I'm not going to constantly rehash 
this.  It's been explained multiple times.

If there are implementation issues within the Linux drivers because of 
peculiarities of hvc then hvc needs to be fixed.  It has nothing to do 
with the driver ABI which is what qemu cares about.

Regards,

Anthony Liguori

> 		Amit
>   
