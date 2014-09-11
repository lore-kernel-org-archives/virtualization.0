From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec include
	file
Date: Thu, 11 Sep 2014 11:53:03 -0400
Message-ID: <5411C55F.5000607@codeaurora.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<CAFEAcA_q7XPr7n=BpkR7oo5GRereO_NJQ5jC3Y2=8ez2xTQLXQ@mail.gmail.com>
	<1410450229.8604.16.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410450229.8604.16.camel@nilsson.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, QEMU Developers <qemu-devel@nongnu.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/11/2014 11:43 AM, Gerd Hoffmann wrote:
> On Do, 2014-09-11 at 16:20 +0100, Peter Maydell wrote:
>> On 11 September 2014 16:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> This patch adds the header file with structs and defines for
>>> the virtio based gpu device.  Covers 2d operations only.
>>
>> Please don't cc subscriber only mailing lists
>> (virtio-dev@lists.oasis-open.org) on posts to qemu-devel;
>> it just means everybody responding gets mailer bounce
>> junkmail.
> 
> I don't feel like splitting the discussion though.  Suggestions how to
> deal with that?  I think I've seen most active virtio-dev folks on the
> virtualization list too, is it ok to just drop virtio-dev for the next
> round and hope that folks see it via virtualization list?

Perhaps you and other subscribers to the offending list can BCC it and
announce that it's BCC'd body.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
