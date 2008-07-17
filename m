From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 13/29] ia64/xen: add definitions necessary for
	xen	eventchannel.
Date: Wed, 16 Jul 2008 22:38:37 -0700
Message-ID: <487EDADD.70804__21236.2177241177$1216273260$gmane$org@goop.org>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>	<12162606623812-git-send-email-yamahata@valinux.co.jp>
	<97C8E7BD1AA462takebe_akio@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <97C8E7BD1AA462takebe_akio@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: xen-ia64-devel@lists.xensource.com, Isaku Yamahata <yamahata@valinux.co.jp>, tony.luck@intel.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Akio Takebe wrote:
>> +enum ipi_vector {
>> +	XEN_RESCHEDULE_VECTOR,
>> +	XEN_IPI_VECTOR,
>> +	XEN_CMCP_VECTOR,
>> +	XEN_CPEP_VECTOR,
>> +
>> +	XEN_NR_IPIS,
>> +};
>> +
>>     
> Don't need empty line.
>   

It's preferred style.  XEN_NR_IPIS is the end sentinel, and nothing 
should be added after it.

    J
