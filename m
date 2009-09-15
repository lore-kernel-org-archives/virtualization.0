From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 15 Sep 2009 15:35:15 +0300
Message-ID: <4AAF8A03.5020806__30739.6634402268$1253018183$gmane$org@redhat.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com> <20090914164750.GB3745@redhat.com>
	<4AAE961B.6020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AAE961B.6020509@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/14/2009 10:14 PM, Gregory Haskins wrote:
> To reiterate, as long as the model is such that the ppc boards are
> considered the "owner" (direct access, no translation needed) I believe
> it will work.  If the pointers are expected to be owned by the host,
> then my model doesn't work well either.
>    

In this case the x86 is the owner and the ppc boards use translated 
access.  Just switch drivers and device and it falls into place.

-- 
error compiling committee.c: too many arguments to function
