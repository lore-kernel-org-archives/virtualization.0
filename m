From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] SCSI driver for VMware's virtual HBA - V4.
Date: Wed, 09 Sep 2009 19:11:34 -0500
Message-ID: <4AA84436.3050205__33244.8051813573$1252541649$gmane$org@codemonkey.ws>
References: <1252458903.24914.73.camel@ank32.eng.vmware.com>	<4AA8177A.2020606@codemonkey.ws>	<1252533093.24633.40.camel@ank32.eng.vmware.com>	<4AA8284A.3010908@codemonkey.ws>	<20090909230854.GA4495@infradead.org>
	<4AA83B88.2020104@codemonkey.ws> <4AA84020.6040504@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AA84020.6040504@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, "Chetan.Loke@Emulex.Com" <Chetan.Loke@Emulex.Com>, Rolf Eike Beer <eike-kernel@sf-tec.de>, James Bottomley <James.Bottomley@suse.de>, Andrew Morton <akpm@linux-foundation.org>, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> On 09/09/09 16:34, Anthony Liguori wrote:
>   
>> We haven't even been successful in getting the Xen folks to present 
>> their work on lkml before shipping it to their users.  Why would we 
>> expect more from VMware if we're willing to merge the Xen stuff?
>>   
>>     
>
> The Xen code may be out of tree, but it has always been readily
> available from a well-known place.  I don't think its comparable.
>   

Once an ABI is set in stone, there's very little that can be done on 
lkml to review the ABI in any serious way.

VMware has repeatedly done this in the past.  Ship a product with their 
own drivers, then submit something to lkml saying that the ABI cannot be 
changed because it's present in a shipping product.

I'll admit, Xen hasn't been as bad as VMware in this regard, but it's 
certainly not perfect either.

Regards,

Anthony Liguori

>     J
>   
