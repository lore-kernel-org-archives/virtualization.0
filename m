From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 1/2] rngd: add udev rule to source from hwrng if virtio-rng
	present
Date: Fri, 08 Aug 2014 14:46:27 -0700
Message-ID: <53E54533.8030109__40458.9021266021$1407534463$gmane$org@linux.intel.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
	<dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
	<53E3D3FF.70707@linux.intel.com> <20140808090715.GG14400@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140808090715.GG14400@grmbl.mre>
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
Cc: jgarzik@bitpay.com, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/08/2014 02:07 AM, Amit Shah wrote:
>
> 
>>  To
>> some degree the above is obsolete when we get khwrngd widely deployed,
>> but that is a new-kernel-only kind of thing.
> 
> Right - I'm wondering if any such changes as propsed here are now
> obsolted already by khwrngd?
> 

In this case, yes, khwrngd would be a better solution for current kernels.

	-hpa
