From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] remoteproc: fix memory leak of remoteproc ida cache
	layers
Date: Thu, 26 Nov 2015 17:47:43 +0200
Message-ID: <CAK=WgbZhfc0_grsA2-VEEBatWOX0b6WeQXKqQm+rvSpzQA1ESA@mail.gmail.com>
References: <1442449758-14594-1-git-send-email-s-anna@ti.com>
	<1442449758-14594-3-git-send-email-s-anna@ti.com>
	<CAK=WgbaYdUU8o-iAqJAOuTd_cXzkcYQ0Nt14beuZ=PwtXGtV3A@mail.gmail.com>
	<20151126103700.GA13200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151126103700.GA13200@redhat.com>
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
Cc: Suman Anna <s-anna@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 26, 2015 at 12:37 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Nov 26, 2015 at 11:38:06AM +0200, Ohad Ben-Cohen wrote:
>> I saw there was some discussion about this between Michael, James and
>> Tejun whether this should be fixed in the IDA core or not.
>>
>> Has it been resolved?
>
> I don't think we reached any conclusions.
> I guess I'll merge the virtio patch as-is then.
> Ohad, would you like to merge 2/2?

Sure, applied 2/2 to remoteproc-fixes. Thanks!
