From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 20 Aug 2009 20:49:30 +0300
Message-ID: <20090820174930.GA9210__48516.1338853233$1250790835$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A808840.70704@codemonkey.ws>
	<20090812173548.GA29981@redhat.com>
	<200908201649.48082.rusty@rustcorp.com.au>
	<20090820170028.GA8908@redhat.com> <4A8D86D5.4090809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8D86D5.4090809@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 20, 2009 at 08:24:37PM +0300, Avi Kivity wrote:
> On 08/20/2009 08:00 PM, Michael S. Tsirkin wrote:
>>
>> Surprisingly, I seem to get better-than-userspace throughput with this
>> benchmark as well.  Here's a test run locally, host-to-guest,
>> over a veth link:

Bleh, I knew it's too good to be true. botched the setup.
Pls disregard this, will post real numbers soon.
Sorry about the noise,

-- 
MST
