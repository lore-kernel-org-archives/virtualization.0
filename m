From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Mon, 09 Sep 2013 10:09:25 +0930
Message-ID: <87li366d6q.fsf__48031.697740271$1378689206$gmane$org@rustcorp.com.au>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
	<20130906082235.GE29367@grmbl.mre> <5229924F.3070007@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5229924F.3070007@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Aaron Lu <aaron.lu@intel.com>, Amit Shah <amit.shah@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Aaron Lu <aaron.lu@intel.com> writes:
> On 09/06/2013 04:22 PM, Amit Shah wrote:
>> On (Fri) 06 Sep 2013 [16:20:05], Aaron Lu wrote:
>>> This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
>>> drivers and virtio pci driver.
>>>
>>> With patch 1/2, two compile warnings are eliminated for virtio pci
>>> driver, and patch 2/2 is a clean up for all virtio drivers as suggested
>>> by Amit Shah.
>> 
>> Thank you.
>
> My pleasure, thanks for your review.
>
> I was addressing a comment for my patch:
> http://marc.info/?l=linux-pm&m=137839111130358&w=2
> and accidentally found this issue here :-)

Thanks, Aaron.

I've applied 1/2 previously, now I've applied 2/2.

Cheers,
Rusty.
