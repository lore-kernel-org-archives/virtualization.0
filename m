From: "Eric Van Hensbergen" <ericvh@gmail.com>
Subject: Re: lguest over qemu
Date: Sat, 25 Aug 2007 10:48:46 -0500
Message-ID: <a4e6962a0708250848v6315a54ag4b314896f7c60807@mail.gmail.com>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184210340.6005.723.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 7/11/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > always get this message (I have insisted with different virtual ram
> > amounts):
> >
> >                     lguest: failed to get page 167304
>
> I did most of my development under qemu, so I don't think that's the
> issue.  Can you send me your .config?
>

I had a different problem which was when I was running a kernel with
WDT's enabled, I was getting a:
   lguest: bad page table entry

Both the advantechwdt and the alimi7101 WDT's were initializing and
reporting I/O address 0x0443 already in use.

I removed the WDT's from the configuration and everything was fine.

          -eric
