From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 1/1] virtio: rng: add derating factor for use by hwrng core
Date: Tue, 12 Aug 2014 07:59:32 -0700
Message-ID: <53EA2BD4.2040903@linux.intel.com>
References: <6f2df652355d6e78da846d06e32489b7d9cdfcc2.1407782982.git.amit.shah@redhat.com>
	<53E93F77.9030305@linux.intel.com>
	<20140812052759.GI4184@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140812052759.GI4184@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: jgarzik@bitpay.com, tytso@mit.edu, herbert@gondor.apana.org.au, kvm list <kvm@vger.kernel.org>, ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, duwe@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On 08/11/2014 10:27 PM, Amit Shah wrote:
> On (Mon) 11 Aug 2014 [15:11:03], H. Peter Anvin wrote:
>> On 08/11/2014 11:49 AM, Amit Shah wrote:
>>> The khwrngd thread is started when a hwrng device of sufficient
>>> quality is registered.  The virtio-rng device is backed by the
>>> hypervisor, and we trust the hypervisor to provide real entropy.  A
>>> malicious hypervisor is a scenario that's ruled out, so we are certain
>>> the quality of randomness we receive is perfectly trustworthy.  Hence,
>>> we use 100% for the factor, indicating maximum confidence in the source.
>>>
>>> Signed-off-by: Amit Shah <amit.shah@redhat.com>
>>
>> It isn't "ruled out", it is just irrelevant: if the hypervisor is
>> malicious, the quality of your random number source is the least of your
>> problems.
> 
> Yea; I meant ruled out in that sense.  Should the commit msg be more
> verbose?
> 

Yes, as it is written it is misleading.

	-hpa
