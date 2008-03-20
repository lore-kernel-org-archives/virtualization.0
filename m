From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [kvm-devel] [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Thu, 20 Mar 2008 13:53:57 -0400
Message-ID: <20080320175357.GA30959__21598.3874201358$1206036694$gmane$org@infradead.org>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 20, 2008 at 05:25:26PM +0100, Carsten Otte wrote:
> @@ -143,6 +143,10 @@ static noinline __init void detect_machi
>  	/* Running on a P/390 ? */
>  	if (cpuinfo->cpu_id.machine == 0x7490)
>  		machine_flags |= 4;
> +
> +	/* Running under KVM ? */
> +	if (cpuinfo->cpu_id.version == 0xfe)
> +		machine_flags |= 64;

Shouldn't these have symbolic names?
