From: Jason Wang <jasowang@redhat.com>
Subject: Re: vhost + multiqueue + RSS question.
Date: Mon, 17 Nov 2014 13:39:20 +0800
Message-ID: <54698A08.4020306@redhat.com>
References: <20141116161818.GD7589@cloudius-systems.com>
	<20141116185604.GA12839@redhat.com>
	<5CC583AB71FC0C44A5CAB54823E83A8422B8ABD4@SINPEX01CL01.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5CC583AB71FC0C44A5CAB54823E83A8422B8ABD4@SINPEX01CL01.citrite.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Venkateswara Rao Nandigam <venkateswararao.nandigam@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gleb Natapov <gleb@cloudius-systems.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2014 12:54 PM, Venkateswara Rao Nandigam wrote:
> I have a question related this topic. So How do you set the RSS Key on the Mellanox NIc? I mean from your Guest?

I believe it's possible but not implemented currently. The issue is the
implementation should not be vendor specific.

TUN/TAP has its own automatic flow steering implementation (flow caches).
>
> If it being set as part of Host driver, is there a way to set it from Guest? I mean my guest will choose a RSS Key and will try to set on the Physical NIC.

Flow caches can co-operate with RFS/aRFS now, so there's indeed some
kind of co-operation between host card and guest I believe.
>
> Thanks,
> Venkatesh
>
