From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC/PATCH 00/15 v3] kvm on big iron
Date: Thu, 27 Mar 2008 14:02:53 +0200
Message-ID: <47EB8CED.60002__27703.7021275193$1206619805$gmane$org@qumranet.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>	
	<1206205354.7177.82.camel@cotte.boeblingen.de.ibm.com>
	<1206467227.6507.36.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206467227.6507.36.camel@cotte.boeblingen.de.ibm.com>
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
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, borntraeger@de.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, os@de.ibm.com, jblunck@suse.de, rvdheij@gmail.com, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> Many thanks for the review feedback we have received so far,
> and many thanks to Andrew for reviewing our common code memory
> management changes. I do greatly appreciate that :-).
>
> All important parts have been reviewed, all review feedback has been
> integrated in the code. Therefore we would like to ask for inclusion of
> our work into kvm.git.
>
> Changes from Version 1:
> - include feedback from Randy Dunlap on the documentation
> - include feedback from Jeremy Fitzhardinge, the prototype for dup_mm
>   has moved to include/linux/sched.h
> - rebase to current kvm.git hash g361be34. Thank you Avi for pulling
>   in the fix we need, and for moving KVM_MAX_VCPUS to include/arch :-).
>
> Changes from Version 2:
> - include feedback from Rusty Russell on the virtio patch
> - include fix for race s390_enable_sie() versus ptrace spotted by Dave 
>   Hansen: we now do task_lock() to protect mm_users from update while 
>   we're growing the page table. Good catch, Dave :-).
> - rebase to current kvm.git hash g680615e
>
>   

Applied all, thanks.


-- 
error compiling committee.c: too many arguments to function
