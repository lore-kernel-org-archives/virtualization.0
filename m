From: Javier Guerra <javier@guerrag.com>
Subject: Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 09:23:44 -0500
Message-ID: <90eb1dc70906150723h4e0e9aa2h253c8411771b6e7e__29772.4314070821$1245075888$gmane$org@mail.gmail.com>
References: <20090610150129.GC28601@redhat.com>
	<4A326B5C.5010501@codemonkey.ws> <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws> <1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com> <1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com> <87ocsp687t.fsf@pike.pond.sub.org>
	<4A3633FD.4010208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3633FD.4010208@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Glauber Costa <glommer@redhat.com>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Carsten Otte <cotte@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 15, 2009 at 6:43 AM, Avi Kivity<avi@redhat.com> wrote:
> (I'd be quite happy constructing the entire machine config on the command
> line, but I realize it's just me)

as a user-only (well, i'm a developer, but don't meddle in kernel
affairs since 0.99pl9); I also like that kvm is totally CLI-managed.

but migration-wise, i think it could be nicer if the 'origin' process
could send the config to the 'target' one.  IOW: the -incoming flag
shouldn't need any other parameter, and the 'migrate' command should
send the whole hardware description before the CPU state, and fail
with a 'can't comply' message if the target complains.

of course, that's a simplification.  for example, the 'target' process
should be able to respect some parameters, mostly the 'external'
descriptions, like storage pathnames, or '-net tap' ones.

-- 
Javier
