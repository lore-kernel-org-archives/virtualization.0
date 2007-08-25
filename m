From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest over qemu
Date: Sun, 26 Aug 2007 07:19:08 +1000
Message-ID: <1188076749.20041.106.camel@localhost.localdomain>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
	<a4e6962a0708250848v6315a54ag4b314896f7c60807@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a4e6962a0708250848v6315a54ag4b314896f7c60807@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-08-25 at 10:48 -0500, Eric Van Hensbergen wrote:
> On 7/11/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > always get this message (I have insisted with different virtual ram
> > > amounts):
> > >
> > >                     lguest: failed to get page 167304
> >
> > I did most of my development under qemu, so I don't think that's the
> > issue.  Can you send me your .config?
> >
> 
> I had a different problem which was when I was running a kernel with
> WDT's enabled, I was getting a:
>    lguest: bad page table entry
> 
> Both the advantechwdt and the alimi7101 WDT's were initializing and
> reporting I/O address 0x0443 already in use.
> 
> I removed the WDT's from the configuration and everything was fine.

Interesting.  Enabling them here gives the expected messages:

        WDT driver for Advantech single board computer initialising.
        advantechwdt: I/O address 0x0443 already in use
        advantechwdt: probe of advantechwdt failed with error -5
        alim7101_wdt: Steve Hill <steve@navaho.co.uk>.
        alim7101_wdt: ALi M7101 PMU not present - WDT not set
        
But it boots fine.

Perhaps it's a hardware difference (we do expose some of the host CPU
capabilities to the guest), or perhaps some other config difference
which is masking the problem?

Thanks,
Rusty.
