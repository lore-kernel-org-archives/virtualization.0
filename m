From: Ian Jackson <Ian.Jackson@eu.citrix.com>
Subject: Re: [Xen-devel] Re: Announcing: Open OVF project source code
	availibility
Date: Wed, 13 Aug 2008 10:37:19 +0100
Message-ID: <18594.43855.262944.943153__34473.0125544176$1218639833$gmane$org@mariner.uk.xensource.com>
References: <20080812143432.GA8431@silverwood.ncultra.org>
	<20080812144656.GQ13067@redhat.com>
	<20080812152634.GA8457@silverwood.ncultra.org>
	<20080812154236.GS13067@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080812154236.GS13067@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: xen-devel@lists.xensource.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, smoser@us.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Daniel P. Berrange writes ("[Xen-devel] Re: Announcing: Open OVF project source code availibility"):
>  Building an XML-RPC
> interface just to call into functions for manipulating OVF files is
> rather overkill. 

Also it is far from clear whether merely changing the concrete
representation of the interface (eg from in-program function call to
XML-RPC, but with identical semantics) can be used to evade the GPL's
`work as a whole' provisions in this way.

This question is disputed and as far as I know has never been tested
in court.

Ian.
