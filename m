From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2.6.31-rc9] net: VMware virtual Ethernet NIC driver:
	vmxnet3
Date: Mon, 28 Sep 2009 17:08:21 -0700 (PDT)
Message-ID: <20090928.170821.124026517.davem__46254.2759989903$1254182924$gmane$org@davemloft.net>
References: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sbhatewara@vmware.com
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, greg@kroah.com, anthony@codemonkey.ws, jgarzik@pobox.com, akpm@linux-foundation.org, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Shreyas Bhatewara <sbhatewara@vmware.com>
Date: Mon, 28 Sep 2009 16:56:45 -0700

> +       uint32_t rxdIdx:12;    /* Index of the RxDesc */

Don't use uint32_t et al. sized types, use "u32" and friends
throughout.
