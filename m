From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 24/29] ia64/pv_ops/xen: implement xen pv_time_ops.
Date: Mon, 21 Jul 2008 11:12:27 +0300
Message-ID: <488444EB.60708__720.56498979709$1216628106$gmane$org@qumranet.com>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>	<12162606623288-git-send-email-yamahata@valinux.co.jp>
	<487EDC6C.5000407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <487EDC6C.5000407@goop.org>
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
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org, Isaku Yamahata <yamahata@valinux.co.jp>, Alex Williamson <alex.williamson@hp.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Isaku Yamahata wrote:
>   
>> implement xen pv_time_ops to account steal time.
>>   
>>     
>
> I think you could just share arch/x86/xen/time.c, couldn't you?  I'd be 
> happy to accept a patch to move all the shareable bits into 
> drivers/xen/time.c.
>
>   
Or maybe, virt/xen/?


-- 
error compiling committee.c: too many arguments to function
