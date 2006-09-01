From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 16:48:11 +0100
Message-ID: <44F8563B.3050505@shadowen.org>
References: <20060901110948.GD15684@skybase>	
	<1157122667.28577.69.camel@localhost.localdomain>
	<1157124674.21733.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1157124674.21733.13.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: schwidefsky@de.ibm.com
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 07:57 -0700, Dave Hansen wrote:
>>> +#define PG_state_change                21      /* HV page state is cha=
nging. */
>>> +#define PG_discarded           22      /* HV page has been discarded. =
*/ =

>> We're already desperately short on page flags on 32-bit architectures.
>> It seems a wee bit silly to add two arch-generic flags for what is a
>> very specialized arch-specific feature at this point.
> =

> There are even three additional page flags if you apply the full set of
> patches.
> =

>> I know that there are 32-bit s390 kernels, but would this be a
>> reasonable feature to restrict to only 64-bit kernels?  That might be a
>> decent compromise.
> =

> Yes, it is definitly an option to make this a 64-bit only features. In
> particular because the ESSA instruction that is used on s390 is only
> available in zarch mode (=3D64 bit).

Wow.  Well there are only 7 extra bits available in 64 bit mode (the
FIELDS area is larger on 64bit machines).  Do we really, really need
three new bits.  What are they being used for here.

-apw
