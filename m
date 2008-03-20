From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Thu, 20 Mar 2008 18:27:53 +0100
Message-ID: <47E29E99.8000509__5956.3944851563$1206034442$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
	<20080320101602.f2737c94.randy.dunlap@oracle.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080320101602.f2737c94.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: aliguori@us.ibm.com, Christian Ehrhardt <EHRHARDT@de.ibm.com>, hollisb@us.ibm.com, arnd@arndb.de, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
>> Index: kvm/arch/s390/kernel/early.c
>> ===================================================================
>> --- kvm.orig/arch/s390/kernel/early.c
>> +++ kvm/arch/s390/kernel/early.c
>> @@ -143,6 +143,10 @@ static noinline __init void detect_machi
>>  	/* Running on a P/390 ? */
>>  	if (cpuinfo->cpu_id.machine == 0x7490)
>>  		machine_flags |= 4;
>> +
>> +	/* Running under KVM ? */
>> +	if (cpuinfo->cpu_id.version == 0xfe)
> 
> Hi,
> 
> Where are these magic numbers documented?  (0x7490, 0xfe, etc.)
> 
> 
>> +		machine_flags |= 64;
>>  }
>>  
>>  #ifdef CONFIG_64BIT
The cpuid (and most other things about s390 arch) are documented in 
the principles of operation:
http://publibz.boulder.ibm.com/epubs/pdf/a2278324.pdf
http://publibz.boulder.ibm.com/epubs/pdf/dz9zs001.pdf

(see chapter "control instructions" - store cpu id)

The 0xfe however is convention, the kvm arch code sets this value 
where it implements that instruction. See "privileged instructions" patch.
