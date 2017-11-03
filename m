From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 0/3] Virtio-balloon Improvement
Date: Fri, 03 Nov 2017 16:35:19 +0800
Message-ID: <59FC2A47.3020103__42057.7980265536$1509697994$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
	<20171022061307-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171022061307-mutt-send-email-mst@kernel.org>
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
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/22/2017 11:19 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 20, 2017 at 07:54:23PM +0800, Wei Wang wrote:
>> This patch series intends to summarize the recent contributions made by
>> Michael S. Tsirkin, Tetsuo Handa, Michal Hocko etc. via reporting and
>> discussing the related deadlock issues on the mailinglist. Please check
>> each patch for details.
>>
>> >From a high-level point of view, this patch series achieves:
>> 1) eliminate the deadlock issue fundamentally caused by the inability
>> to run leak_balloon and fill_balloon concurrently;
> We need to think about this carefully. Is it an issue that
> leak can now bypass fill? It seems that we can now
> try to leak a page before fill was seen by host,
> but I did not look into it deeply.
>
> I really like my patch for this better at least for
> current kernel. I agree we need to work more on 2+3.
>

Since we have many customers interested in the "Virtio-balloon 
Enhancement" series,
please review the v17 patches first (it has a dependency on your patch 
for that deadlock fix,
so I included it there too), and we can get back to 2+3 here after that 
series is done. Thanks.

Best,
Wei
