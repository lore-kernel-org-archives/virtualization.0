From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 9/9] kvm/x86: Hyper-V kvm exit
Date: Fri, 16 Oct 2015 13:51:08 +0300
Message-ID: <20151016105107.GO12593__35758.9521016509$1444993385$gmane$org@rkaganb.sw.ru>
References: <1444979273-6587-1-git-send-email-den@openvz.org>
	<1444979273-6587-10-git-send-email-den@openvz.org>
	<5620AC9E.4050905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5620AC9E.4050905@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 16, 2015 at 09:51:58AM +0200, Paolo Bonzini wrote:
> The documentation should include the definition of the struct and the
> definition of the subtypes (currently KVM_EXIT_HYPERV_SYNIC only).
> 
> Documentation for KVM_CAP_HYPERV_SINIC and KVM_IRQ_ROUTING_HV_SINT is
> missing, too.
> 
> Finally, it would be better to have unit tests in kvm-unit-tests.
> Either this or QEMU support is a requirement for merging, and the unit
> tests are probably easier.

OK we'll try to get this done early next week.

Thanks,
Roman.
