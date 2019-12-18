From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Wed, 18 Dec 2019 15:43:43 +0100
Message-ID: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b__24640.3762650274$1576683667$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Michael,

with 
commit db7286b100b503ef80612884453bed53d74c9a16 (refs/bisect/skip-db7286b100b503ef80612884453bed53d74c9a16)
    vhost: use batched version by default
plus
commit 6bd262d5eafcdf8cdfae491e2e748e4e434dcda6 (HEAD, refs/bisect/bad)
    Revert "vhost/net: add an option to test new code"
to make things compile (your next tree is not easily bisectable, can you fix that as well?).

I get random crashes in my s390 KVM guests after reboot.
Reverting both patches together with commit decd9b8 "vhost: use vhost_desc instead of vhost_log" to
make it compile again) on top of linux-next-1218 makes the problem go away.

Looks like the batched version is not yet ready for prime time. Can you drop these patches until
we have fixed the issues?

Christian
