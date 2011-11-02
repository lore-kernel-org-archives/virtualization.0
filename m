From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Additional virtio-mmio spec changes
Date: Wed, 2 Nov 2011 13:31:05 +0000
Message-ID: <CAFEAcA_hJK3fT-mvtJj9ZfQ2cGsv0Oy5vpbir=XfmP4HG+7o2g__21303.6025096246$1321323098$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty wrote:
>Pawel Moll <pawel.moll@arm.com> wrote:
>> Peter also mentioned that he didn't like the "Num" in
>> "QueueNum" register name and would rather see it called "QueueSize". I
>> have no strong opinions either way and can provide patches to both the
>> spec and the driver (and header) to change it. Any thoughts?
>
> Num isn't great, but Size might be misleading.  I'd leave it...

I'd note that calling it QueueNum  is inconsistent with the main
virtio spec, which calls the equivalent virtio header field
"Queue Size". Also if the docs say

"QueueNum
 Virtual queue size.
 Queue size is a number of elements in the queue [...]"

this rather suggests to me that we've picked the wrong name for
the register...

-- PMM
