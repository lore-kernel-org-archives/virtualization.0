From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 4/6] Rename the parainstructions symbols to be consistent
	with the others
Date: Tue, 10 Apr 2007 20:07:48 +0200
Message-ID: <200704102007.49163.ak@suse.de>
References: <20070404010655.400913479@goop.org>
	<20070404011453.598418421@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070404011453.598418421@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007 03:06:59 Jeremy Fitzhardinge wrote:
> The other symbols used to delineate the alt-instructions sections have
> the form __foo/__foo_end.  Rename parainstructions to match.

This patch breaks x86-64

-Andi

> =
