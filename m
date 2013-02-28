From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: virtio PCI on KVM without IO BARs
Date: Thu, 28 Feb 2013 16:43:38 +0100
Message-ID: <512F7B2A.5080108__18365.2286803865$1362068667$gmane$org@siemens.com>
References: <20130228152433.GA13832@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130228152433.GA13832@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2013-02-28 16:24, Michael S. Tsirkin wrote:
> Another problem with PIO is support for physical virtio devices,
> and nested virt: KVM currently programs all PIO accesses
> to cause vm exit, so using this device in a VM will be slow.

Not answering your question, but support for programming direct PIO
access into KVM's I/O bitmap would be feasible. Such feature may have
some value for assigned devices that use PIO more heavily. They cause
lengthy user-space exists so far.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux
