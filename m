From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 37/43] lguest: Virtio helper routines for a descriptor
	ringbuffer implementation
Date: Tue, 02 Oct 2007 14:21:07 +1000
Message-ID: <1191298867.6979.60.camel@localhost.localdomain>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063651.769960367@rustcorp.com.au>
	<46FFD6CB.9020904@qumranet.com>
	<1191240202.6648.11.camel@localhost.localdomain>
	<4700E45E.6080505@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4700E45E.6080505@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: lguest@ozlabs.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-10-01 at 14:13 +0200, Avi Kivity wrote:
> Rusty Russell wrote:
> > Yes, but this is what lguest is for, to play without fixing an ABI.  I
> > fully expect incompatible tweaks before KVM causes the ABI to nail down.
> 
> I'm worried about users tearing down the "caution, experimental ABI,
> will invalidate warranty" sticker from the package, selecting
> CONFIG_EXPERIMENTAL, CONFIG_I_REALLY_MEAN_ITS_EXPERIMENTAL, and
> CONFIG_I_DONT_CARE_IF_THIS_BLOWS_UP, not reading your blog, and running
> 2.6.24 guests on top of 2.6.25 or vice versa.
> 
> I want the module not to load instead of the guest blowing up.

Well, this is the guest side we're talking about.  We can use some bogus
vendor ID for the experimental devices so that they simply won't be
found by the final drivers.

Cheers,
Rusty.
