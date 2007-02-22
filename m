From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 14:49:00 -0800
Message-ID: <45DE1DDC.2020006@goop.org>
References: <45DCFB6E.2010806@goop.org>	
	<1172115803.13378.63.camel@localhost.localdomain>	
	<45DD6EF7.9060808@goop.org>
	<1172141757.13378.76.camel@localhost.localdomain>
	<45DDDD50.80502@goop.org> <45DE15B4.9060109@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45DE15B4.9060109@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> That's looking pretty spiffy, if you ask me. =


Cool.  I had a quick look to see what you're doing in vmi and decided to
let you work out what to do...

That version had a couple of bugs in it, but the pushed version works
for me (PAE at least; fixing non-PAE at the moment).  I also included
Ingo's patch to use -freg-struct-return, with the corresponding updates
to paravirt.h, since they make more of the native operations noops.

    J
