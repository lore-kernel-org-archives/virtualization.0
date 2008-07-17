From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [PATCH 13/29] ia64/xen: add definitions necessary for xen
	eventchannel.
Date: Thu, 17 Jul 2008 12:27:56 +0900
Message-ID: <97C8E7BD1AA462takebe_akio__27658.8739864112$1216265441$gmane$org@jp.fujitsu.com>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
	<12162606623812-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12162606623812-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hi, Isaku

I have a trivial comment.

>+enum ipi_vector {
>+	XEN_RESCHEDULE_VECTOR,
>+	XEN_IPI_VECTOR,
>+	XEN_CMCP_VECTOR,
>+	XEN_CPEP_VECTOR,
>+
>+	XEN_NR_IPIS,
>+};
>+
Don't need empty line.

Best Regards,

Akio Takebe
