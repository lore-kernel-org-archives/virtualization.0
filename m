From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ia64, xen: compilation fix caused by
	79741dd35713ff4f6fd0eafd59fa94e8a4ba922d
Date: Thu, 15 Jan 2009 10:24:37 -0800
Message-ID: <57C9024A16AD2D4C97DC78E552063EA35CD259CC__25096.6079104275$1232044034$gmane$org@orsmsx505.amr.corp.intel.com>
References: <20090115061655.GM1565%yamahata@valinux.co.jp>
	<1232009643.30152.6.camel@localhost>
	<20090115103206.GT1565%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090115103206.GT1565%yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "virtualization@linuxfoundation.org" <virtualization@linuxfoundation.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

> > I assume that this patch will be pushed via the ia64 patch queue, no?
>
> I suppose that Tony would handle it. Tony?

Yes.  I'll put that in.

Yamahata-san: Would you please send me a .config file that
I can check in as arch/ia64/configs/xen_defconfig so I can
add a xen build to my regular regression run. Or more than
one if there are some interesting combinations of CONFIG
options that should be tested.  I'm not looking for complete
coverage of all the combinations, just the main sets that
are likely to be used in real systems.

Thanks.

-Tony
