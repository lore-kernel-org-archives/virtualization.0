From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Fri, 10 Aug 2007 19:25:43 +0100
Message-ID: <20070810192543.605f350f__14271.4021065787$1186770009$gmane$org@the-village.bc.nu>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de> <46BB5258.8040609@goop.org>
	<20070809190303.214e5457@the-village.bc.nu>
	<5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708101108y62ebfa26n9f47bfc52b48f4a8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Steven@smtp2.linux-foundation.org, lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 10 Aug 2007 15:08:35 -0300
"Glauber de Oliveira Costa" <glommer@gmail.com> wrote:

> On 8/9/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > What's the EBDA actually used for?  The only place which seems to use
> > > ebda_addr is in the e820 code to avoid that area as RAM.
> >
> > It belongs to the firmware.
> 
> Wouldn't it be better, then, to just skip this step unconditionally if
> we are running a paravirtualized guest? What do we from doing it?

An EBDA is an optional BIOS feature so providing you virtualise the
relevant entry in the zero page (to avoid guest applications trying to
scan the EBDA for some system tables they may want to use like DMI) as
a zero entry you can ignore the EBDA.

That probably the right thing to do since the host EBDA won't match the
guest environment and the guest might migrate anyway
