From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] virtio_net: lower limit on buffer size
Date: Sat, 3 Jun 2017 23:17:30 +0300
Message-ID: <aafb81af-54f2-06b0-3b5c-2713bc28184b__21586.0222852372$1496521061$gmane$org@cogentembedded.com>
References: <1496361148-4603-1-git-send-email-mst@redhat.com>
	<3dd90d56-7110-bb9e-0b7f-4c8a8003a57f@cogentembedded.com>
	<20170602202536.GA24411@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170602202536.GA24411@fieldses.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/02/2017 11:25 PM, J. Bruce Fields wrote:

>>> commit d85b758f72b0 "virtio_net: fix support for small rings"
>>
>>    Commit d85b758f72b0 ("virtio_net: fix support for small rings")
>>
>>> was supposed to increase the buffer size for small rings
>>> but had an unintentional side effect of decreasing
>>> it for large rings. This seems to break some setups -
>>> it's not yet clear why, but increasing buffer size
>>> back to what it was before helps.
>>>
>>> Fixes: d85b758f72b0 "virtio_net: fix support for small rings"
>>
>> Fixes: d85b758f72b0 ("virtio_net: fix support for small rings")
>
> I may be bikeshedding, but, personally I never do the parens--they're
> redundant given the quotes, and space is often tight.

    Just see Documetation/process/submitting-patches.rst.

MBR, Sergei
