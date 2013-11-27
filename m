From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH char-misc-linus 4/5] misc: mic: Fix sparse warnings and
	other endianness issues.
Date: Wed, 27 Nov 2013 09:12:01 -0800
Message-ID: <m3zjopwyzi.fsf__37907.1671552539$1386087593$gmane$org@adixit-yct.ra.intel.com>
References: <cover.1385487752.git.ashutosh.dixit@intel.com>
	<e5bcd02bd49b111e2d4f885655461e889b8049a3.1385487752.git.ashutosh.dixit@intel.com>
	<20131126191525.GA29279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131126191525.GA29279@kroah.com> (Greg Kroah-Hartman's message
	of "Tue, 26 Nov 2013 12:15:25 -0700")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Dutt, Sudeep" <sudeep.dutt@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yerramreddy, Siva Krishna Kumar Reddy" <siva.krishna.kumar.reddy.yerramreddy@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Yokoyama,
	Caz" <caz.yokoyama@intel.com>, "Chandramouli,
	Dasaratharaman" <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 26 2013 at 11:15:25 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 26, 2013 at 10:14:21AM -0800, Ashutosh Dixit wrote:
>> Endianness issues are now consistent as per the documentation in
>> host/mic_virtio.h. Note that the host can be both BE or LE whereas the
>> card is always LE.
>>
>> Memory space sparse warnings are fixed for now by using __force. This is
>> sufficient for now since the driver depends on x86 but will need to be
>> revisited if we support other architectures which treat I/O memory
>> differently from system memory.
>
> Can you split the endian fixes up from the user pointer fixes to make it
> easier to review/apply?

We've just submitted v3 where we now have separate patches (5 and 6) for
endianness and sparse memory access fixes.

> There's no need for this for 3.13-final, right?  No bug fixes are here
> that I can tell.

That's correct.  I've reordered the patches so that v3 patches 1-4
contain the real bug fixes. We'd like to apply patches 5 and 6 for
3.13-final too but if it is not possible we can drop one or both of them
for now for further review.

> And don't use __force, really, can't you fix this some other way?

As stated in the description for patch 6, because of the dependence of
the MIC drivers on the virtio infrastructure there is no simple way to
fix these memory space issues at present. Since the sparse warnings do
not represent real issues the warnings are being suppressed using
__force.

>> +	vq = vring_new_virtqueue(index, le16_to_cpu(config.num),
>> +				 MIC_VIRTIO_RING_ALIGN, vdev, false,
>> +				 (void __force *)va, mic_notify, callback,
>> +				 name);
>
> Why __force a void * here?  That feels wrong.

In all instances in patch 6 __force is used to strip the __iomem
attribute (e.g. va is declared as 'void __iomem *va;').

thanks,

ashutosh
