From: Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH] vhost/scsi: Use safe iteration in
	vhost_scsi_complete_cmd_work()
Date: Thu, 16 Nov 2017 10:33:32 +0900
Message-ID: <55bbb1fd-894a-2309-4dfe-ed9ca19e7c4d__11567.7380505533$1511414915$gmane$org@lge.com>
References: <1510186649-9765-1-git-send-email-byungchul.park@lge.com>
	<20171115235239.GA4394@X58A-UD3R>
	<20171116033036-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171116033036-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-team@lge.com
List-Id: virtualization@lists.linuxfoundation.org

On 11/16/2017 10:30 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 16, 2017 at 08:52:39AM +0900, Byungchul Park wrote:
>> On Thu, Nov 09, 2017 at 09:17:29AM +0900, Byungchul Park wrote:
>>> I am sorry for having made a mistake on it.
>>
>> Hello Nicholas,
>>
>> Please consider this patch urgently. I'm sorry for having changed the
>> original behavior with the previous patch.
>>
>> The safe version of llist API should be used to keep the original
>> behavior.
>>
>> Thanks,
>> Byungchul
> 
> I have included this patch in my tree.

Thank you.

-- 
Thanks,
Byungchul
