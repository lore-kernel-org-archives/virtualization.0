From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 16:38:52 -0800
Message-ID: <45EF5B1C.4050605@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	
	<1173178774.24738.311.camel@localhost.localdomain>	
	<45EDD82F.90204@vmware.com>	
	<1173225182.24738.507.camel@localhost.localdomain>	
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	
	<1173228544.24738.514.camel@localhost.localdomain>	
	<45EE0D10.7070807@vmware.com>	
	<1173230305.24738.529.camel@localhost.localdomain>	
	<45EE1EA3.90803@vmware.com>	
	<1173256666.24738.576.camel@localhost.localdomain>	
	<45EEF966.6060902@goop.org>	<Line.LNX.4.64.0703071304080.1851@d.namei>	
	<45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>	
	<1173302503.24738.795.camel@localhost.localdomain>	
	<45EF372E.7030600@goop.org>	
	<1173308717.24738.898.camel@localhost.localdomain>	
	<45EF4BD7.7060400@goop.org>
	<1173314124.24738.947.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173314124.24738.947.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tglx@linutronix.de
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> Sigh. The cut zero hairball is already in mainline. :(
>   =


Yes, there were a couple of unfortunate patches in that series, but they
got fast-tracked in with the promise they would get fixed asap.

> Sure. If the clockevent API is changed, then the users get fixed. This
> is not my main concern. The "oh we reuse the PIT interrupt" reachout is
> what makes life hard. VMI does this already extensive and I'm frightened
> by it.
>   =


Well, I think they know what's expected of them now.

    J
