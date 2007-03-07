From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 14:28:03 -0800
Message-ID: <45EF3C73.2020201@vmware.com>
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
	<45EEF966.6060902@goop.org>	
	<1173300032.24738.750.camel@localhost.localdomain>	
	<45EF2991.1020204@goop.org>	
	<1173303639.24738.814.camel@localhost.localdomain>	
	<45EF2FFE.7010705@vmware.com>	
	<1173305670.24738.849.camel@localhost.localdomain>	
	<45EF39F3.8050506@vmware.com>
	<1173306713.24738.861.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173306713.24738.861.camel@localhost.localdomain>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/07/2007 02:31 PM, Thomas Gleixner wrote:
> Please make these things self contained and not relying on whatever
> time_init_hook() contains.
> =


Fixing up the code to do this now....

thanks,
Dan
