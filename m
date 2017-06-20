From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Tue, 20 Jun 2017 21:01:58 +0200
Message-ID: <338ec5ce-759b-6381-0442-ac0741f159b8__21576.5705718242$1497985335$gmane$org@redhat.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<20170620211445-mutt-send-email-mst@kernel.org>
	<f46768db-dcda-aa40-64b9-eb2929249db8@redhat.com>
	<20170620215552-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170620215552-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: aarcange@redhat.com, Rik van Riel <riel@redhat.com>, amit.shah@redhat.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Dave Hansen <dave.hansen@intel.com>, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, Nitesh Narayan Lal <nilal@redhat.com>, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org


>> IMHO even simply writing all-zeros to all free pages before starting
>> migration (or even when freeing a page) would be a cleaner interface
>> than this (because it atomically works with the entity the host cares
>> about for migration). But yes, performance is horrible that's why I am
>> not even suggesting it. Just saying that this mm interface is very very
>> special and if we could find something better, I'd favor it.
> 
> As long as there's a single user, changing to a better interface
> once it's found won't be hard at all :)
> 

Hehe, more like "we made this beautiful virtio-balloon extension" - oh
there is free page hinting (assuming that it does not reuse the batch
interface here). Guess how long it would take to at least show that free
page hinting can be done. If it takes another 6 years, I am totally on
your side ;)

-- 

Thanks,

David
