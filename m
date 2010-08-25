From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 1/3] S390: take a full byte as ext_param indicator
Date: Wed, 25 Aug 2010 18:20:20 -0300
Message-ID: <20100825212020.GA2345__4907.80602344802$1282771545$gmane$org@amt.cnet>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1282657732-20902-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, borntraeger@de.ibm.com, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 24, 2010 at 03:48:50PM +0200, Alexander Graf wrote:
> Currenty the ext_param field only distinguishes between "config change" and
> "vring interrupt". We can do a lot more with it though, so let's enable a
> full byte of possible values and constants to #defines while at it.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> 
> v1 -> v2:
> 
>   - move defines to virtio_s390.h
> ---
>  arch/s390/include/asm/kvm_virtio.h |    6 ++++++
>  drivers/s390/kvm/kvm_virtio.c      |   19 +++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)

Applied, thanks.
