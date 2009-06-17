From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 01/13] qemu: make default_write_config use mask table
Date: Wed, 17 Jun 2009 14:49:42 +0300
Message-ID: <20090617114942.GB30859__20353.4377892085$1245239801$gmane$org@redhat.com>
References: <cover.1244635350.git.mst@redhat.com>
	<20090610122804.GB27174@redhat.com> <4A38032D.5060506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A38032D.5060506@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 16, 2009 at 03:40:13PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> Change much of hw/pci to use symbolic constants and a table-driven
>> design: add a mask table with writable bits set and readonly bits unset.
>> Detect change by comparing original and new registers.
>>
>> This makes it easy to support capabilities where read-only/writeable
>> bit layout differs between devices, depending on capabilities present.
>>
>> As a result, writing a single byte in BAR registers now works as
>> it should. Writing to upper limit registers in the bridge
>> also works as it should. Code is also shorter.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> This series introduces warning (virtio_load decl/def does not match).

Seems to match and build cleanly with -Werror for me.
What warning do you see?
