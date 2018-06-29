From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Date: Fri, 29 Jun 2018 17:28:56 +0200
Message-ID: <909d0983-bb54-25bb-03f5-7a28ded76500@redhat.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
	<c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
	<20180629172216-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180629172216-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>> And looking at all the discussions and problems that already happened
>> during the development of this series, I think we should rather look
>> into how clean free page hinting might solve the same problem.
> 
> I'm not sure I follow the logic. We found that neat tricks
> especially re-using the max order free page for reporting.

Let me rephrase: history of this series showed that this is some really
complicated stuff. I am asking if this complexity is actually necessary.

No question that we had a very valuable outcome so far (that especially
is also relevant for other projects like Nitesh's proposal - talking
about virtio requests and locking).

> 
>> If it can't be solved using free page hinting, fair enough.
> 
> I suspect Nitesh will need to find a way not to have mm code
> call out to random drivers or subsystems before that code
> is acceptable.
> 
> 


-- 

Thanks,

David / dhildenb
