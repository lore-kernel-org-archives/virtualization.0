From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC/PATCH 01/15] preparation: provide	hook	to	enable
	pgstes in user pagetable
Date: Tue, 25 Mar 2008 08:12:28 +0200
Message-ID: <47E897CC.2020509__17359.5843291425$1206425914$gmane$org@qumranet.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>	
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>	
	<47E29EC6.5050403@goop.org>	<1206040405.8232.24.camel@nimitz.home.sr71.net>	
	<47E2CAAC.6020903@de.ibm.com>	
	<1206124176.30471.27.camel@nimitz.home.sr71.net>	
	<20080322175705.GD6367@osiris.boeblingen.de.ibm.com>	
	<47E62DBA.4050102@qumranet.com>
	<1206296609.10233.5.camel@localhost>
	<47E750ED.7060509@qumranet.com> <47E896EA.5060309@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E896EA.5060309@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, Heiko Carstens <heiko.carstens@de.ibm.com>, Dave Hansen <haveblue@us.ibm.com>, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> Avi Kivity wrote:
>> Well, dup_mm() can't work (and now that I think about it, for more 
>> reasons -- what if the process has threads?).
> We lock out multithreaded users already, -EINVAL.
>

Would be much better if this can be avoided.  It's surprising.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
