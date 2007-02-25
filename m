From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: PARAVIRT_SAVE_FLAGS_IRQ_DISABLE composite callsite
Date: Sun, 25 Feb 2007 01:40:55 -0800
Message-ID: <45E159A7.7060709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

What was the point of this again?  Was it that these two operations are
used so commonly together that its worth having a special type for them,
or is there some correctness issue here?

It seems to me that having it adds a fair amount of fiddley complexity,
and it doesn't gain very much because patching will make each operation
individually fairly efficient.

    J
