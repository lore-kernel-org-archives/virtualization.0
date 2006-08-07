From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 11:40:00 +0300
Message-ID: <20060807084000.GA3802@rhun.haifa.ibm.com>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<200608070730.17813.ak@muc.de>
	<1154930669.7642.12.camel@localhost.localdomain>
	<200608070817.42074.ak@muc.de>
	<20060807062705.GB4979@rhun.haifa.ibm.com>
	<Pine.LNX.4.61.0608070934030.12594@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608070934030.12594@yvahk01.tjqt.qr>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 07, 2006 at 09:34:43AM +0200, Jan Engelhardt wrote:
> =

> >baremetal.h seems appropriate.
> =

> <vanilla.h>, in hommage to "vanilla kernel".

I think most people use 'vanilla' to mean 'mainline', as in Linus's
kernel, so I find 'baremetal' (as opposed to 'virtualized') more
appropriate but... since this thread has all of the characteristics of
your favorite bike-shed, I'll bow out of it now :-)

Cheers,
Muli
