From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: EXPORT_SYMBOL_GPL(paravirt_ops);
Date: Thu, 10 Aug 2006 12:40:58 -0700
Message-ID: <20060810194058.GK2654@sequoia.sous-sol.org>
References: <44DB73F5.5040009@goop.org>
	<20060810183250.GJ2654@sequoia.sous-sol.org>
	<44DB84CA.6040900@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44DB84CA.6040900@vmware.com>
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

* Zachary Amsden (zach@vmware.com) wrote:
> EXPORT_SYMBOL_GPL is still possible - if you patch over every op in =

> paravirt_ops.  Then only the paravirt modules need to be GPL, not all =

> modules.

Problem is the pervasive nature.  So any old module that was doing
local_irq_disable() will need access to the paravirt_ops structure via

local_irq_disable() -> raw_local_irq_disable -> paravirt_ops.irq_disable()

IOW, all modules need paravirt_ops access, otherwise non-GPL modules
will fail to load with "Unknown symbol paravirt_ops."  We can't make an
interface change like that.

thanks,
-chris
