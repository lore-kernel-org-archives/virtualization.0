From: "H. Peter Anvin" <h.peter.anvin@intel.com>
Subject: Re: [PATCH char-misc-linus 5/5] misc: mic: Fix user space namespace
	pollution from mic_common.h.
Date: Tue, 26 Nov 2013 10:12:49 -0800
Message-ID: <5294E4A1.9080905__42418.6157914393$1386087494$gmane$org@intel.com>
References: <cover.1385487752.git.ashutosh.dixit@intel.com>
	<a0760d072de1531018bdfb4a1f5d1f6e35def26c.1385487752.git.ashutosh.dixit@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a0760d072de1531018bdfb4a1f5d1f6e35def26c.1385487752.git.ashutosh.dixit@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ashutosh Dixit <ashutosh.dixit@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Siva Krishna Kumar Reddy Yerramreddy <siva.krishna.kumar.reddy.yerramreddy@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/26/2013 10:15 AM, Ashutosh Dixit wrote:
> Avoid declaring ALIGN() and __aligned() in
> include/uapi/linux/mic_common.h since they pollute user space
> namespace. Also, mic_aligned_size() can be simply replaced simply by
> sizeof() since all structures where mic_aligned_size() is used are
> declared using __attribute__ ((aligned(8)));
> 
> +#define MIC_ALIGN(a, x) (((a) + (x) - 1) & ~((x) - 1))
>  

This is still user namespace.  I would suggest __mic_align() or
_MIC_ALIGN() instead, unless you're actively expecting user code to make
use of this macro (in which case it should be made more robust.)

	-hpa
