From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 21:37:12 +0200
Message-ID: <871vob4047.fsf@basil.nowhere.org>
References: <20090720160025.GA20249@kroah.com>
	<20090720162810.GA22102@kroah.com> <20090720165941.GA15660@redhat.com>
	<20090720170345.GA23990@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090720170345.GA23990@suse.de> (Greg KH's message of "Mon,
	20 Jul 2009 10:03:45 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: devel@driverdev.osuosl.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Haiyang@firstfloor.org, Dave Jones <davej@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH <gregkh@suse.de> writes:
>
> It's the "normal" way of cleaning up code.  Start with a known-working
> piece of stuff, and incrementally clean it up. 

I have to agree with David. This is essentially unreviewable
in the original state. It would be good if you could
do all the obvious cleanups first and then post a consolidated
series.

Most "obvious" cleanups should not change the binary, so
you can easily check they are correct by comparing the assembler
code.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
