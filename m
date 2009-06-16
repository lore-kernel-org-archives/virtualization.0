From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCHv4 01/13] qemu: make default_write_config use mask table
Date: Tue, 16 Jun 2009 15:40:13 -0500
Message-ID: <4A38032D.5060506__42084.9951486618$1245185015$gmane$org@us.ibm.com>
References: <cover.1244635350.git.mst@redhat.com>
	<20090610122804.GB27174@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090610122804.GB27174@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Change much of hw/pci to use symbolic constants and a table-driven
> design: add a mask table with writable bits set and readonly bits unset.
> Detect change by comparing original and new registers.
>
> This makes it easy to support capabilities where read-only/writeable
> bit layout differs between devices, depending on capabilities present.
>
> As a result, writing a single byte in BAR registers now works as
> it should. Writing to upper limit registers in the bridge
> also works as it should. Code is also shorter.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
This series introduces warning (virtio_load decl/def does not match).

-- 
Regards,

Anthony Liguori
