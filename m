From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-users] Re: State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 11:45:37 -0700
Message-ID: <48920851.3080401@goop.org>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
	<4891FFBA.1020702@goop.org> <20080731183634.GA27147@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20080731183634.GA27147@gallifrey>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Grant McWilliams <grantmasterflash@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Dr. David Alan Gilbert wrote:
> Does that include things like /proc/cpuinfo?  Current Dom0's seem
> to lose some of the physical IDs information from there.

Dom0's vcpus don't necessarily have any fixed relationship to the
underlying physical cpus, so there's no real way they could.  Dom0 might
not even have as many vcpus as there are pcpus.  So I think that's expected.

    J
